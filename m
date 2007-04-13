From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Fri, 13 Apr 2007 08:00:46 +0200
Message-ID: <461F1C8E.1010104@cosmosbay.com>
References: <200704120530.l3C5UGbv022814@zach-dev.vmware.com> <461EDBF1.4080904@zytor.com> <461EE9E5.6060403@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070104060507040302030402"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751690AbXDMGCJ@vger.kernel.org>
In-Reply-To: <461EE9E5.6060403@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------070104060507040302030402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Zachary Amsden a écrit :
> 
> Yes.  Even then, last time I clocked instructions, xchg was still slower 
> than read / write, although I could be misremembering.  And it's not 
> totally clear that they will always be in cached state, however, and for 
> SMP, we still want to drop the implicit lock in cases where the 
> processor might not know they are cached exclusive, but we know there 
> are no other racing users.  And there are plenty of old processors out 
> there to still make it worthwhile.
> 

Is there one processor that benefit from this patch then ?

I couldnt get a win on my test machines, maybe they are not old enough ;)

umask() doesnt need xchg() atomic semantic. If several threads are using 
umask() concurrently results are not guaranted anyway.

--------------070104060507040302030402
Content-Type: text/plain;
 name="umask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="umask.patch"

--- linux-2.6.21-rc6/kernel/sys.c
+++ linux-2.6.21-rc6-ed/kernel/sys.c
@@ -2138,8 +2138,10 @@ asmlinkage long sys_getrusage(int who, s
 
 asmlinkage long sys_umask(int mask)
 {
-	mask = xchg(&current->fs->umask, mask & S_IRWXUGO);
-	return mask;
+	struct fs_struct *fs = current->fs;
+	int old = fs->umask;
+	fs->umask = mask & S_IRWXUGO;
+	return old;
 }
     
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,

--------------070104060507040302030402--

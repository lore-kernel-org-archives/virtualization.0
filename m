From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE	segment
 in vmlinux II
Date: Tue, 22 Aug 2006 08:13:59 -0700
Message-ID: <44EB1F37.6030902@goop.org>
References: <1156256777.5091.93.camel@localhost.localdomain> <200608221659.18896.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932300AbWHVPOF@vger.kernel.org>
In-Reply-To: <200608221659.18896.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Ian Campbell <Ian.Campbell@xensource.com>, Andrew Morton <akpm@osdl.org>, Ian Pratt <ian.pratt@xensource.com>, Xen-devel <xen-devel@lists.xensource.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization <virtualization@lists.osdl.org>, Christoph Lameter <clameter@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Sorry I tried to apply it, but at least 2.6.18rc4 mainline (which my tree
> is based on) doesn't have a NOTES macro so it doesn't link
>
> I dropped the NOTES addition for now, presumably it will need to be readded
> later.

Yes, Ian's patch is incremental on top of mine, which defines the NOTES 
macro in include/asm-generic/vmlinux.lds.h:

#define NOTES                                                           \
                .notes : { *(.note.*) } :note


    J

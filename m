From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Thu, 12 Apr 2007 23:25:13 -0700
Message-ID: <461F2249.9090905@zytor.com>
References: <200704120530.l3C5UGbv022814@zach-dev.vmware.com> <461EDBF1.4080904@zytor.com> <461EE9E5.6060403@vmware.com> <461F1C8E.1010104@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752022AbXDMG1b@vger.kernel.org>
In-Reply-To: <461F1C8E.1010104@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric Dumazet wrote:
> 
> Is there one processor that benefit from this patch then ?
> 

At least P5 systems should benefit.

	-hpa

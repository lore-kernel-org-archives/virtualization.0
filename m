From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 03/25] xen: Add nosegneg capability to the vsyscall page
 notes
Date: Mon, 23 Apr 2007 23:19:05 -0700
Message-ID: <462DA159.2030600@goop.org>
References: <20070424042653.37F421801A4@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161657AbXDXGSj@vger.kernel.org>
In-Reply-To: <20070424042653.37F421801A4@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland McGrath <roland@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Roland McGrath wrote:
>> I have to admit I still don't really understand all this.  Is it
>> documented somewhere?
>>     
>
> I have explained it in public more than once, but I don't know off hand
> anywhere that was helpfully recorded.
>   

Thanks very much.  I'd been poking about, but the closest I came to an
actual description was various patches fixing bugs, so it was a little
incomplete.

> For example, a Xen-enabled kernel can use a single vDSO image (or a single
> pair of int80/sysenter images), containing the "nosegneg" hwcap note.  When
> there is no need for it (native or hvm or 64-bit hv or whatever), it just
> clears the mask word.  If you actually do this, you'll want to modify the
> NOTE_KERNELCAP_BEGIN macro to define a global label you can use with VDSO_SYM.
>   

Thanks for the pointer.  I'd been getting a bit of heat for enabling the
nonegseg flag unconditionally.  If I can make Xen-specific then that
will be one less source of complaints.

    J

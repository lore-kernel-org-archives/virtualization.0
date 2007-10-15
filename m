From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for 2.6.24
Date: Mon, 15 Oct 2007 14:59:50 -0700
Message-ID: <4713E2D6.90801@goop.org>
References: <20071015204840.074767068@goop.org> <20071015215406.GA1588@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763176AbXJOWAi@vger.kernel.org>
In-Reply-To: <20071015215406.GA1588@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> Yeah, but you cc:ed all 12 patches to stable@.  The majority of which we
> don't want to take, right?  Which specific ones should stable@ care
> about?

Crap, sorry about that.  I'd just intended to send the overview and the
four patches, which have explicit CC: stable lines in the patch
descriptions.  They are:

Subject: [PATCH 06/12] xen: add batch completion callbacks
Subject: [PATCH 07/12] xen: deal with stale cr3 values when unpinning
pagetables
Subject: [PATCH 10/12] xen: fix incorrect vcpu_register_vcpu_info
hypercall argument
Subject: [PATCH 12/12] xfs: eagerly remove vmap mappings to avoid
upsetting Xen

    J

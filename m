From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 14:54:16 -0700
Message-ID: <46CCB088.8070606@goop.org>
References: <46CBC842.4070100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934059AbXHVVy0@vger.kernel.org>
In-Reply-To: <46CBC842.4070100@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> This patch provides hypercalls for the i386 port I/O instructions,
> which vastly helps guests which use native-style drivers.  For certain
> VMI workloads, this provides a performance boost of up to 30%.  We
> expect KVM and lguest to be able to achieve similar gains on I/O
> intensive workloads.

Two comments:

- I should dust off my "break up paravirt_ops" patch, and this would fit
nicely into it (I think we already discussed this)

- What happens if you *don't* want to pv some of the io instructions? 
What if you have a device which is directly exposed to the guest?

    J

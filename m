From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 12:11:06 -0400
Message-ID: <46CC601A.4010005@garzik.org>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com> <1187763956.6174.48.camel@localhost.localdomain> <20070822103545.GG2642@bingen.suse.de> <46CC0719.2080103@qumranet.com> <20070822110810.GO32640@bingen.suse.de> <46CC0EAF.3000805@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764707AbXHVQLZ@vger.kernel.org>
In-Reply-To: <46CC0EAF.3000805@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> And even then, all the performance 
> sensitive stuff uses mmio, no?


Depends on the hardware.

	Jeff

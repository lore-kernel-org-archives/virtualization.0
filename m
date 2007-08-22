From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 09:16:16 -0700
Message-ID: <46CC6150.6050105@vmware.com>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com> <46CBCC58.3010700@vmware.com> <46CBF5DD.6040300@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932317AbXHVQVl@vger.kernel.org>
In-Reply-To: <46CBF5DD.6040300@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>
> Since this is only for newer kernels, won't updating the driver to use 
> a hypercall be more efficient?  Or is this for existing out-of-tree 
> drivers?

Actually, it is for in-tree drivers that we emulate but don't want to 
pollute, and one out of tree driver (that will hopefully be in tree 
soon!) that has no way to determine if making hypercalls is acceptable.

Zach

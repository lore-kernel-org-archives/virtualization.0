From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 17:49:34 -0800
Message-ID: <457E0AAE.7080509@goop.org>
References: <457E0460.4030107@goop.org> <457E08FE.6050600@vmware.com> <457E097C.5030208@goop.org> <457E0A03.3020704@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750861AbWLLBuJ@vger.kernel.org>
In-Reply-To: <457E0A03.3020704@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> It's not for us or Xen.  Perhaps it came from lhype?  

(I suspect it came from Andi's fevered brain.)  If lhype can't deal with
vdso, it can turn it off for itself - but I don't think its a problem
for lhype.

    J

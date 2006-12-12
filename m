From: Zachary Amsden <zach@vmware.com>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 17:42:22 -0800
Message-ID: <457E08FE.6050600@vmware.com>
References: <457E0460.4030107@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750849AbWLLBmY@vger.kernel.org>
In-Reply-To: <457E0460.4030107@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Hi Andi,
>
> What problem do they cause together?  There's certainly no problem with
> Xen+vdso (in fact, its actually very useful so that it picks up the
> right libc with Xen-friendly TLS).
>   

Methinks the compat VDSO support got broken in the config?  Paravirt + 
COMPAT_VDSO are incompatible.

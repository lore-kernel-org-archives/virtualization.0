From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386: introduce voyager smp_ops, fix voyager build
Date: Sat, 28 Apr 2007 16:46:23 -0700
Message-ID: <4633DCCF.2060809@goop.org>
References: <463382E5.9060701@goop.org>	<m14pn0dv2j.fsf@ebiederm.dsl.xmission.com> <4633D5E9.8030403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754429AbXD1XqT@vger.kernel.org>
In-Reply-To: <4633D5E9.8030403@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
>   
>> Unless I have missed something early_gdt_descr still needs to be updated. 
>>   
>>     
>
> The patch is on top of Andi's current queue, which includes quite a few
> boot-time gdt setup cleanups.  early_gdt_descr has gone.

Hm, I was thinking of something else.  Checking...

    J

From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 19:17:48 -0600
Message-ID: <m1odjzxigz.fsf@ebiederm.dsl.xmission.com>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <466087CF.70708@goop.org>
	<4660924A.2070009@zytor.com> <466093E3.4010701@goop.org>
	<46609636.4050208@zytor.com> <4660BBDF.1040007@goop.org>
	<4660BCF8.7000208@zytor.com> <4660C0CD.5060606@goop.org>
	<4660C194.4010003@zytor.com> <4660C2F6.6070005@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761925AbXFBBTF@vger.kernel.org>
In-Reply-To: <4660C2F6.6070005@goop.org> (Jeremy Fitzhardinge's message of
	"Fri, 01 Jun 2007 18:08:06 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> H. Peter Anvin wrote:
>> It would have to, because of the way code32_start is defined to work.
>> We don't get control again after its use as a hook.
>>   
>
> Who uses that hook?  The impression I get is that the execution
> environment for jumping to that pointer is not very well defined at present.

loadlin.

Eric

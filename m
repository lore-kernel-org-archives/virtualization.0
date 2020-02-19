From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH] x86/ioperm: add new paravirt function update_io_bitmap
Date: Wed, 19 Feb 2020 10:46:15 +0100
Message-ID: <4537af8d-e28f-1c27-53a9-e3208874037e@suse.com>
References: <20200218154712.25490-1-jgross@suse.com>
 <87mu9fr4ky.fsf@nanos.tec.linutronix.de>
 <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
 <8736b7q6ca.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8736b7q6ca.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 19.02.20 10:22, Thomas Gleixner wrote:
> Jürgen Groß <jgross@suse.com> writes:
>> On 18.02.20 22:03, Thomas Gleixner wrote:
>>> BTW, why isn't stuff like this not catched during next or at least
>>> before the final release? Is nothing running CI on upstream with all
>>> that XEN muck active?
>>
>> This problem showed up by not being able to start the X server (probably
>> not the freshest one) in dom0 on a moderate aged AMD system.
>>
>> Our CI tests tend do be more text console based for dom0.
> 
> tools/testing/selftests/x86/io[perm|pl] should have caught that as well,
> right? If not, we need to fix the selftests.

Hmm, yes. Thanks for the pointer.

Will ask our testing specialist what is done in this regard and how it
can be enhanced.


Juergen

From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH] x86/ioperm: add new paravirt function update_io_bitmap
Date: Wed, 19 Feb 2020 06:35:16 +0100
Message-ID: <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
References: <20200218154712.25490-1-jgross@suse.com>
 <87mu9fr4ky.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87mu9fr4ky.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 18.02.20 22:03, Thomas Gleixner wrote:
> Juergen Gross <jgross@suse.com> writes:
>> Commit 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control
>> ioperm() as well") reworked the iopl syscall to use I/O bitmaps.
>>
>> Unfortunately this broke Xen PV domains using that syscall as there
>> is currently no I/O bitmap support in PV domains.
>>
>> Add I/O bitmap support via a new paravirt function update_io_bitmap
>> which Xen PV domains can use to update their I/O bitmaps via a
>> hypercall.
>>
>> Fixes: 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
>> Reported-by: Jan Beulich <jbeulich@suse.com>
>> Cc: <stable@vger.kernel.org> # 5.5
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Reviewed-by: Jan Beulich <jbeulich@suse.com>
>> Tested-by: Jan Beulich <jbeulich@suse.com>
> 
> Duh, sorry about that and thanks for fixing it.
> 
> BTW, why isn't stuff like this not catched during next or at least
> before the final release? Is nothing running CI on upstream with all
> that XEN muck active?

This problem showed up by not being able to start the X server (probably
not the freshest one) in dom0 on a moderate aged AMD system.

Our CI tests tend do be more text console based for dom0.


Juergen

From: Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH] x86/ioperm: add new paravirt function update_io_bitmap
Date: Wed, 19 Feb 2020 09:29:41 +0100
Message-ID: <e1617641-2106-cd81-628f-569b1a8cf1f7@suse.com>
References: <20200218154712.25490-1-jgross@suse.com>
 <87mu9fr4ky.fsf@nanos.tec.linutronix.de>
 <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Hellstrom <thellstrom@vmware.com>, Stefano Stabellini <sstabellini@kernel.org>, "VMware, Inc." <pv-drivers@vmware.com>, stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 19.02.2020 06:35, Jürgen Groß wrote:
> On 18.02.20 22:03, Thomas Gleixner wrote:
>> Juergen Gross <jgross@suse.com> writes:
>>> Commit 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control
>>> ioperm() as well") reworked the iopl syscall to use I/O bitmaps.
>>>
>>> Unfortunately this broke Xen PV domains using that syscall as there
>>> is currently no I/O bitmap support in PV domains.
>>>
>>> Add I/O bitmap support via a new paravirt function update_io_bitmap
>>> which Xen PV domains can use to update their I/O bitmaps via a
>>> hypercall.
>>>
>>> Fixes: 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
>>> Reported-by: Jan Beulich <jbeulich@suse.com>
>>> Cc: <stable@vger.kernel.org> # 5.5
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> Reviewed-by: Jan Beulich <jbeulich@suse.com>
>>> Tested-by: Jan Beulich <jbeulich@suse.com>
>>
>> Duh, sorry about that and thanks for fixing it.
>>
>> BTW, why isn't stuff like this not catched during next or at least
>> before the final release? Is nothing running CI on upstream with all
>> that XEN muck active?
> 
> This problem showed up by not being able to start the X server (probably
> not the freshest one) in dom0 on a moderate aged AMD system.

Not the freshest one, yes, but also on a system where KMS would not
be available (my success rate with KMS is rather low overall, and
with newer Linux I see rather more systems to stop working than ones
to become working, but I simply don't have the time to investigate).

Jan

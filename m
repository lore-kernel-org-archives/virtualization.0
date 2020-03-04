From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Wed, 4 Mar 2020 11:22:04 -0800
Message-ID: <627fe5d2-e6c3-4eff-1a58-14e17dc04ac5@zytor.com>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
 <20200304092136.GI2596@hirez.programming.kicks-ass.net>
 <202003041019.C6386B2F7@keescook>
 <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
 <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Garnier <thgarnie@chromium.org>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, the arch/x86 maintainers <x86@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kees Cook <keescook@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh
List-Id: virtualization@lists.linuxfoundation.org

On 2020-03-04 11:19, Thomas Garnier wrote:
>>
>> The huge memory model, required for arbitrary placement, has a very
>> significant performance impact.
> 
> I assume you mean mcmodel=large, it doesn't use it. It uses -fPIE and
> removes -mcmodel=kernel. It favors relative references whenever
> possible.
> 

I know... this was in reference to a comment of Kees'.

	-hpa

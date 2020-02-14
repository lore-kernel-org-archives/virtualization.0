From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 41/62] x86/sev-es: Handle MSR events
Date: Fri, 14 Feb 2020 08:59:39 -0800
Message-ID: <d43a1cc5-4229-e1fb-2a7a-d701d7b12ea9@intel.com>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-42-joro@8bytes.org>
 <b688b4ad-5a64-d2df-6dd8-e23fac75a6b9@intel.com>
 <20200214072324.GE22063@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200214072324.GE22063@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On 2/13/20 11:23 PM, Joerg Roedel wrote:
> Yes, investigating this is on the list for future optimizations (besides
> caching CPUID results). My idea is to use alternatives patching for
> this. But the exception handling is needed anyway because #VC
> exceptions happen very early already, basically the first thing after
> setting up a stack is calling verify_cpu(), which uses CPUID.

Ahh, bummer.  How does a guest know that it's running under SEV-ES?
What's the enumeration mechanism if CPUID doesn't "work"?

> The other reason is that things like MMIO and IOIO instructions can't be
> easily patched by alternatives. Those would work with the runtime
> checking you showed above, though.

Is there a reason we can't make a rule that you *must* do MMIO through
an accessor function so we *can* patch them?  I know random drivers
might break the rule, but are SEV-ES guests going to be running random
drivers?  I would think that they mostly if not all want to use virtio.

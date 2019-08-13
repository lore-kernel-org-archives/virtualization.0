From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 01/92] kvm: introduce KVMI (VM introspection
	subsystem)
Date: Tue, 13 Aug 2019 11:11:10 +0200
Message-ID: <81f6c33e-6851-8272-bd8e-7b0bf9ef1ff9@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-2-alazar@bitdefender.com>
	<20190812202030.GB1437@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190812202030.GB1437@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhang@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mircea_C=c3=aerjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/08/19 22:20, Sean Christopherson wrote:
> The refcounting approach seems a bit backwards, and AFAICT is driven by
> implementing unhook via a message, which also seems backwards.  I assume
> hook and unhook are relatively rare events and not performance critical,
> so make those the restricted/slow flows, e.g. force userspace to quiesce
> the VM by making unhook() mutually exclusive with every vcpu ioctl() and
> maybe anything that takes kvm->lock. 

The reason for the unhook event, as far as I understand, is because the
introspection appliance can poke int3 into the guest and needs an
opportunity to undo that.

I don't have a big problem with that and the refcounting, at least for
this first iteration---it can be tackled later, once the general event
loop is simplified---however I agree with the other comments that Sean
made.  Fortunately it should not be hard to apply them to the whole
patchset with search and replace on the patches themselves.

Paolo

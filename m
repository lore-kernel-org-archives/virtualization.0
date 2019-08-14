From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 64/92] kvm: introspection: add single-stepping
Date: Wed, 14 Aug 2019 14:53:46 +0200
Message-ID: <5851eb00-3d00-1213-99cb-7bab2da3ba89@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-65-alazar@bitdefender.com>
	<20190812205038.GC1437@linux.intel.com>
	<f03ff5fbba2a06cd45d5bebb46da4416bc58e968.camel@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f03ff5fbba2a06cd45d5bebb46da4416bc58e968.camel@bitdefender.com>
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
To: Nicusor CITU <ncitu@bitdefender.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, "Zhang@linux.intel.com" <Zhang@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Joerg Roedel <joro@8bytes.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Yu C <yu.c.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>, Jim Mattson <jmattson@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On 14/08/19 14:36, Nicusor CITU wrote:
> Thank you for signaling this. This piece of code is leftover from the
> initial attempt to make single step running.
> Based on latest results, we do not actually need to change
> interruptibility during the singlestep. It is enough to enable the MTF
> and just suppress any interrupt injection (if any) before leaving the
> vcpu entering in guest.
> 

This is exactly what testcases are for...

Paolo

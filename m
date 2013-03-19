From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 0/2] tcm_vhost hotplug/hotunplug support
Date: Tue, 19 Mar 2013 14:47:26 +0100
Message-ID: <51486C6E.9030401@redhat.com>
References: <1363056339-6061-1-git-send-email-asias@redhat.com>
	<1363643172.3156.62.camel@haakon2.linux-iscsi.org>
	<20130318215350.GA21091@redhat.com> <514831AA.4030500@redhat.com>
	<20130319134552.GB12913@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130319134552.GB12913@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 19/03/2013 14:45, Michael S. Tsirkin ha scritto:
> On Tue, Mar 19, 2013 at 10:36:42AM +0100, Paolo Bonzini wrote:
>> Il 18/03/2013 22:53, Michael S. Tsirkin ha scritto:
>>> Sorry, no, I'd prefer we get userspace support in qemu in first.
>>> If there's only a single user for this driver (kvmtool),
>>> then it was a mistake to merge it, the right thing would be to freeze it
>>> and look at whether we can drop it completely.
>>
>> I'm still not sure why this matters for this patch, since it does not
>> change the userspace ABI.
> 
> It enables a new feature bit.

How does that matter if userspace is not supposed to do anything special
with that bit?

Paolo

>>> I really don't want this, I hope it will be merged and all will
>>> be shiny, but I think it's wrong to rush in more code,
>>> we have some time before the next merge window.

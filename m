From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
	feature bit to virtio_net
Date: Wed, 13 Jun 2018 17:56:06 -0700
Message-ID: <CADGSJ21gEYTMQv+-nOxXiwKmFp0c5EDqfCXHqy2EbF3iLZfuXg@mail.gmail.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
	<20180606002650-mutt-send-email-mst@kernel.org>
	<CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
	<20180612143554-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180612143554-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 12, 2018 at 4:47 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jun 05, 2018 at 03:09:26PM -0700, Siwei Liu wrote:
>> The thing is cloud service provider might prefer sticking to the same
>> level of service agreement (SLA) of keeping VF over migration,
>
> That requirement is trivially satisfied by just a single VF :) If your
> SLA does not require live migration, you should do just that.

The requirement is enable live migration by default without getting
user too much attention. Migration should be attempted if guest is
live migratable. If not, present a single VF to legacy guest.

You seem to think it's not a valid use case? Or impossible to do so?
What if I have something in mind that can support my theory as well?

-Siwei

>
> --
> MST

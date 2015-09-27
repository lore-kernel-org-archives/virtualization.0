From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Sat, 26 Sep 2015 23:49:42 -0700
Message-ID: <CAF1ivSYek_Y0pO4zNN4vkxxPmNTSN=mR1hwOPyzGuUeHTjKtug__24376.3181534179$1443336609$gmane$org@mail.gmail.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<1442470241.23132.77.camel@haakon3.risingtidesystems.com>
	<1442532687.4750.6.camel@ssi>
	<1442537752.11959.35.camel@haakon3.risingtidesystems.com>
	<1442599957.11660.8.camel@ssi>
	<1442610544.10492.33.camel@haakon3.risingtidesystems.com>
	<1443049097.28503.13.camel@ssi>
	<1443330116.15432.57.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443330116.15432.57.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: "Minturn, Dave B" <dave.b.minturn@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 26, 2015 at 10:01 PM, Nicholas A. Bellinger
<nab@linux-iscsi.org> wrote:
>
> Btw, after chatting with Dr. Hannes this week at SDC here are his
> original rts-megasas -v6 patches from Feb 2013.
>
> Note they are standalone patches that require a sufficiently old enough
> LIO + QEMU to actually build + function.
>
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-qemu-v6.patch
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-fabric-v6.patch
>
> For groking purposes, they demonstrate the principle design for a host
> kernel level driver, along with the megasas firmware interface (MFI)
> specific emulation magic that makes up the bulk of the code.
>
> Take a look.

Big thanks. Reading the patches now.

>
> --nab
>

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Tue, 27 Feb 2018 23:23:35 +0200
Message-ID: <20180227231731-mutt-send-email-mst@kernel.org>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180220104224.GA2031@nanopsycho>
	<CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
	<20180227084959.GB2005@nanopsycho>
	<CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 01:16:21PM -0800, Alexander Duyck wrote:
> The other thing I am looking at is trying to find a good way to do
> dirty page tracking in the hypervisor using something like a
> para-virtual IOMMU. However I don't have any ETA on that as I am just
> starting out and have limited development time. If we get that in
> place we can leave the VF in the guest until the very last moments
> instead of having to remove it before we start the live migration.
> 
> - Alex

I actually think your old RFC would be a good starting point:
https://lkml.org/lkml/2016/1/5/104

What is missing is I think enabling/disabling dynamically.

Seems to be easier than tracking by the hypervisor.

-- 
MST

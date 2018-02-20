From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Tue, 20 Feb 2018 14:33:56 -0800
Message-ID: <20180220143356.3467084d@cakuba.netronome.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180220104224.GA2031@nanopsycho>
	<CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
	<20180220162933.GD2031@nanopsycho>
	<509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
	<20180220201410.GF2031@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180220201410.GF2031@nanopsycho>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 20 Feb 2018 21:14:10 +0100, Jiri Pirko wrote:
> Yeah, I can see it now :( I guess that the ship has sailed and we are
> stuck with this ugly thing forever...
> 
> Could you at least make some common code that is shared in between
> netvsc and virtio_net so this is handled in exacly the same way in both?

IMHO netvsc is a vendor specific driver which made a mistake on what
behaviour it provides (or tried to align itself with Windows SR-IOV).
Let's not make a far, far more commonly deployed and important driver
(virtio) bug-compatible with netvsc.

To Jiri's initial comments, I feel the same way, in fact I've talked to
the NetworkManager guys to get auto-bonding based on MACs handled in
user space.  I think it may very well get done in next versions of NM,
but isn't done yet.  Stephen also raised the point that not everybody is
using NM.

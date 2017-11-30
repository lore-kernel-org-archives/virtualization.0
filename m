From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Thu, 30 Nov 2017 16:14:37 +0200
Message-ID: <20171130161125-mutt-send-email-mst__7686.3681468696$1512051305$gmane$org@kernel.org>
References: <20171128112722.00003716@intel.com>
	<0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 30, 2017 at 11:29:56AM +0800, Jason Wang wrote:
> If my understanding is correct there's no need to for any extension of
> virtio spec.

There appears to be a concern that some existing configurations
might use same MAC for an unrelated reason. Not sure what
that could be, but for sure, we could add a feature flag.
That needs to be approved by the virtio TC, but it's
just a single line in the spec no big deal, we can help here.

> If this is true, maybe you can start to prepare the patch?

Yes, please do. We can add a safeguard of a feature bit on top.

-- 
MST

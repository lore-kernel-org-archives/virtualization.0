From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC (resend) net-next 0/6] virtio-net: Add support for
	virtio-net header extensions
Date: Mon, 24 Apr 2017 20:04:43 +0300
Message-ID: <20170424200232-mutt-send-email-mst__17227.046020753$1493053499$gmane$org@kernel.org>
References: <1492274298-17362-1-git-send-email-vyasevic@redhat.com>
	<0d9216af-e3db-e06b-f70d-d77f519c3fd4@redhat.com>
	<f52fa31e-5ca2-34dc-d48b-417a34061359@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f52fa31e-5ca2-34dc-d48b-417a34061359@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, Vladislav Yasevich <vyasevich@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 20, 2017 at 11:34:57AM -0400, Vlad Yasevich wrote:
> > - For 1.1, do we really want something like vnet header? AFAIK, it was not used by modern
> > NICs, is this better to pack all meta-data into descriptor itself? This may need a some
> > changes in tun/macvtap, but looks more PCIE friendly.
> 
> That would really be ideal and I've looked at this.

We already have at least 16 unused bits in the used ring
(head is 16 bit we are using 32 for it).

-- 
MST

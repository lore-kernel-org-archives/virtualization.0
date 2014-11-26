From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 11/42] virtio: add legacy feature table support
Date: Wed, 26 Nov 2014 10:19:57 +0100
Message-ID: <20141126101957.6bd6989c.cornelia.huck@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-12-git-send-email-mst@redhat.com>
	<20141125185342.761bf72e.cornelia.huck@de.ibm.com>
	<20141125213942.GD22343@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141125213942.GD22343@redhat.com>
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
Cc: Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 23:39:42 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 25, 2014 at 06:53:42PM +0100, Cornelia Huck wrote:
> > On Tue, 25 Nov 2014 18:42:09 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > -	dev->features = driver_features & device_features;
> > > +	/* Some drivers have a separate feature tables for virtio v1.0 */
> > 
> > /* some drivers have a separate feature table for legacy virtio */
> > 
> > ?
> 
> I prefer have separate feature tables:  drivers (plural) have tables
> (plural).
> 
> Agree?

Yes, provided you drop the 'a' :)

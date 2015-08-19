From: Victor Kaplansky <victork@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-net: rephrase devconf fields description
Date: Wed, 19 Aug 2015 14:54:37 +0300
Message-ID: <20150819143550-mutt-send-email-victork__33651.9988639795$1440078083$gmane$org@redhat.com>
References: <1439732494-29765-1-git-send-email-victork@redhat.com>
	<1439732494-29765-2-git-send-email-victork@redhat.com>
	<55D14A62.2060408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55D14A62.2060408@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 17, 2015 at 10:43:46AM +0800, Jason Wang wrote:
> 
> 
> On 08/16/2015 09:42 PM, Victor Kaplansky wrote:
> > Clarify general description of the mac, status and
> > max_virtqueue_pairs fields. Specifically, the old description is
> > vague about configuration layout and fields offsets when some of
> > the fields are non valid.
> >
> > Also clarify that validity of two status bits depends on two
> > different feature flags.
> >
> > Signed-off-by: Victor Kaplansky <victork@redhat.com>
> > ---
> > +
> > +\item [\field{max_virtqueue_pairs}] tells the driver the maximum
> > +    number of each of virtqueues (receiveq1\ldots receiveqN and
> > +    transmitq1\ldots transmitqN respectively) that can be configured
> > +    on the device once VIRTIO_NET_F_MQ is negotiated.
> > +    \field{max_virtqueue_pairs} is valid only if VIRTIO_NET_F_MQ is
> > +    set and can be read by the driver.
> > +
> 
> 
> I don't get the point that adding "can be read by the driver". Looks
> like it's hard for hypervisor to detect this?

AFAIU, if the device sets VIRTIO_NET_F_MQ, the device also sets
the value of 'max_virtqueue_pairs' even before driver negotiated
VIRTIO_NET_F_MQ. If so, the driver can read the value of
'max_virtqueue_pairs' during negotiation and potentially this
value can even affect negotiation decision of the driver.  

If above is correct, I'll change the description to make this
point more clear.

Thanks,
-- Victor

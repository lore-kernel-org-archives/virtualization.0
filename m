From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Tue, 27 Feb 2018 23:30:12 +0200
Message-ID: <20180227232437-mutt-send-email-mst__40010.0772655152$1519766928$gmane$org@kernel.org>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180220104224.GA2031@nanopsycho>
	<CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
	<20180227084959.GB2005@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180227084959.GB2005@nanopsycho>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 09:49:59AM +0100, Jiri Pirko wrote:
> Now the question is: is it possible to merge the demands you have and
> the generic needs I described into a single solution? From what I see,
> that would be quite hard/impossible. So at the end, I think that we have
> to end-up with 2 solutions:
> 1) virtio_net, netvsc in-driver bonding - very limited, stupid, 0config
>    solution that works for all (no matter what OS you use in VM)
> 2) team/bond solution with assistance of preferably userspace daemon
>    getting info from baremetal. This is not 0config, but minimal config
>    - user just have to define this "magic bonding" should be on.
>    This covers all possible usecases, including multiple VFs, RDMA, etc.
> 
> Thoughts?

I think I agree. This RFC is trying to do 1 above.  Looks like we now
all agree 1 and 2 are not exclusive, both have place in the kernel. Is
that right?

-- 
MST

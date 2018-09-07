From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 06/11] tuntap: split out XDP logic
Date: Fri, 7 Sep 2018 10:16:38 -0400
Message-ID: <20180907101606-mutt-send-email-mst__2644.69852340898$1536329846$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-7-jasowang@redhat.com>
	<20180906131703-mutt-send-email-mst@kernel.org>
	<84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2018 at 11:29:34AM +0800, Jason Wang wrote:
> > > +		if (act != XDP_PASS)
> > > +			goto out;
> > likely?
> 
> It depends on the XDP program, so I tend not to use it.

Point is XDP_PASS is already slow.

-- 
MST

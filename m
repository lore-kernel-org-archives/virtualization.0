From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/3] virtio-iommu: a paravirtualized IOMMU
Date: Sat, 8 Apr 2017 00:19:22 +0300
Message-ID: <20170407211922.GA23772__35842.1743651435$1491599978$gmane$org@redhat.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, kvm@vger.kernel.org, cdall@linaro.org, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 07, 2017 at 08:17:44PM +0100, Jean-Philippe Brucker wrote:
> There are a number of advantages in a paravirtualized IOMMU over a full
> emulation. It is portable and could be reused on different architectures.
> It is easier to implement than a full emulation, with less state tracking.
> It might be more efficient in some cases, with less context switches to
> the host and the possibility of in-kernel emulation.

Thanks, this is very interesting. I am read to read it all, but I really
would like you to expand some more on the motivation for this work.
Productising this would be quite a bit of work. Spending just 6 lines on
motivation seems somewhat disproportionate. In particular, do you have
any specific efficiency measurements or estimates that you can share?

-- 
MST

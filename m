From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH kvmtool 00/15] Add virtio-iommu
Date: Mon, 22 May 2017 15:01:45 +0100
Message-ID: <3e2988b9-eed7-3718-d8c8-170ba62db284__47015.9680968665$1495461502$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
	<AM5PR0401MB2545FADDF2A7649DF0DB68309AF80@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AM5PR0401MB2545FADDF2A7649DF0DB68309AF80@AM5PR0401MB2545.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Bharat,

On 22/05/17 09:26, Bharat Bhushan wrote:
> Hi Jean,
> 
> I am trying to run and review on my side but I see Linux patches are not with latest kernel version.
> Will it be possible for you to share your Linux and kvmtool git repository reference?

Please find linux and kvmtool patches at the following repos:

git://linux-arm.org/kvmtool-jpb.git virtio-iommu/base
git://linux-arm.org/linux-jpb.git virtio-iommu/base

Note that these branches are unstable, subject to fixes and rebase. I'll
try to keep them in sync with upstream.

Thanks,
Jean

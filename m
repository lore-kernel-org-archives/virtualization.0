From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Thu, 5 Sep 2019 13:59:10 +0000
Message-ID: <20190905135907.GB6011__11323.6388818891$1567691971$gmane$org@mellanox.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905122736.19768-1-jasowang@redhat.com>
Content-Language: en-US
Content-ID: <A9EFBDB41F67594A8536A97722126F60@eurprd05.prod.outlook.com>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jglisse@redhat.com" <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 05, 2019 at 08:27:34PM +0800, Jason Wang wrote:
> Hi:
> 
> Per request from Michael and Jason, the metadata accelreation is
> reverted in this version and rework in next version.
> 
> Please review.
> 
> Thanks
> 
> Jason Wang (2):
>   Revert "vhost: access vq metadata through kernel virtual address"
>   vhost: re-introducing metadata acceleration through kernel virtual
>     address

There are a bunch of patches in the queue already that will help
vhost, and I a working on one for next cycle that will help alot more
too.

I think you should apply the revert this cycle and rebase the other
patch for next..

Jason

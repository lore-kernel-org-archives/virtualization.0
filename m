From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH repost] Fix panic in virtnet_remove
Date: Thu, 21 Jul 2011 21:29:50 -0700 (PDT)
Message-ID: <20110721.212950.1991725607632413241.davem__37151.3663711541$1311309123$gmane$org@davemloft.net>
References: <20110720135602.18705.21405.sendpatchset@krkumar2.in.ibm.com>
	<20110720143115.GB6787@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110720143115.GB6787@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: krkumar2@in.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, shemminger@vyatta.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 20 Jul 2011 17:31:15 +0300

> On Wed, Jul 20, 2011 at 07:26:02PM +0530, Krishna Kumar wrote:
>> Fix a panic in virtnet_remove. unregister_netdev has already
>> freed up the netdev (and virtnet_info) due to dev->destructor
>> being set, while virtnet_info is still required. Remove
>> virtnet_free altogether, and move the freeing of the per-cpu
>> statistics from virtnet_free to virtnet_remove.
>> 
>> Tested patch below.
>> 
>> Signed-off-by: Krishna Kumar <krkumar2@in.ibm.com>
> 
> Also note that the crash was apparently introduced by
> 3fa2a1df909482cc234524906e4bd30dee3514df in net-next,
> so this is a net-next only patch.
> 
> Stephen, was there any special reason to free the memory
> in the destructor like you did?
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Applied.

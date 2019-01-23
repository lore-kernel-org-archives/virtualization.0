From: David Miller <davem@redhat.com>
Subject: Re: [PATCH net-next V4 0/5] vhost: accelerate metadata access
	through vmap()
Date: Wed, 23 Jan 2019 09:24:12 -0800 (PST)
Message-ID: <20190123.092412.1232153663747428685.davem__33971.1858586938$1548264448$gmane$org@redhat.com>
References: <20190123095557.30168-1-jasowang@redhat.com>
	<20190123085652-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190123085652-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 23 Jan 2019 08:58:07 -0500

> On Wed, Jan 23, 2019 at 05:55:52PM +0800, Jason Wang wrote:
>> This series tries to access virtqueue metadata through kernel virtual
>> address instead of copy_user() friends since they had too much
>> overheads like checks, spec barriers or even hardware feature
>> toggling.
>> 
>> Test shows about 24% improvement on TX PPS. It should benefit other
>> cases as well.
> 
> ok I think this addresses most comments but it's a big change and we
> just started 1.1 review so to pls give me a week to review this ok?

Ok. :)

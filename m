From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Sun, 11 Aug 2019 21:13:43 -0700 (PDT)
Message-ID: <20190811.211343.1920857192153512765.davem@davemloft.net>
References: <20190809054851.20118-1-jasowang@redhat.com>
	<20190810134948-mutt-send-email-mst@kernel.org>
	<360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: jgg@ziepe.ca, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2019 10:44:51 +0800

> On 2019/8/11 上午1:52, Michael S. Tsirkin wrote:
>> At this point how about we revert
>> 7f466032dc9e5a61217f22ea34b2df932786bbfc
>> for this release, and then re-apply a corrected version
>> for the next one?
> 
> If possible, consider we've actually disabled the feature. How about
> just queued those patches for next release?

I'm tossing this series while you and Michael decide how to move forward.

From: Asias He <asias@redhat.com>
Subject: Re: [PATCH RESEND 0/5] Add vhost-blk support
Date: Mon, 16 Jul 2012 17:05:02 +0800
Message-ID: <5003D93E.2000304__30665.4563210488$1342429414$gmane$org@redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
	<20120714074911.GA31684@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120714074911.GA31684@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-aio@kvack.org, Dave Kleikamp <dave.kleikamp@oracle.com>, Zach Brown <zab@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Moyer <jmoyer@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph,

On 07/14/2012 03:49 PM, Christoph Hellwig wrote:
> Please send a version that does direct block I/O similar to xen-blkback
> for now.

Seems xen-blkback converts the guest IO request to host bio and submit 
them directly. I was wondering whether this has a performance gain 
compared to AIO implementation.

> If we get proper in-kernel aio support one day you can add
> back file backend support.

I talked with Dave and Zack on the in-kernel aio patch which James 
pointed out:

http://marc.info/?l=linux-fsdevel&m=133312234313122

Dave will post a new version soon. I will wait for it.

-- 
Asias

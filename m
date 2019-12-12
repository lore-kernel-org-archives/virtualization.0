From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Date: Thu, 12 Dec 2019 11:01:59 -0800 (PST)
Message-ID: <20191212.110159.1715559793988195794.davem__26785.4736581043$1576177334$gmane$org@davemloft.net>
References: <20191212123624.ahyhrny7u6ntn3xt@steredhat>
 <20191212075356-mutt-send-email-mst@kernel.org>
 <20191212131453.yocx6wckoluwofbb@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212131453.yocx6wckoluwofbb@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: sgarzare@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Dec 2019 14:14:53 +0100

> On Thu, Dec 12, 2019 at 07:56:26AM -0500, Michael S. Tsirkin wrote:
>> On Thu, Dec 12, 2019 at 01:36:24PM +0100, Stefano Garzarella wrote:
>> I'd say it's better to backport to all stable releases where it applies,
>> but yes it's only a security issue in 5.4.  Dave could you forward pls?
> 
> Yes, I agree with you.
> 
> @Dave let me know if I should do it.

I've queued it up for -stable.

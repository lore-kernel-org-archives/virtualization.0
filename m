From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC 2/2] virtio-ring: Allocate indirect buffers from cache when
	possible
Date: Tue, 28 Aug 2012 14:54:07 +0200
Message-ID: <503CBF6F.1030406@gmail.com>
References: <1340028598-10142-1-git-send-email-levinsasha928@gmail.com>
	<1340028598-10142-2-git-send-email-levinsasha928@gmail.com>
	<4FE01355.6070909@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FE01355.6070909@6wind.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Mickael Guerin <jean-mickael.guerin@6wind.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/19/2012 07:51 AM, Jean-Mickael Guerin wrote:
>> +    if (vq->vring.desc[i].flags&  VRING_DESC_F_INDIRECT) {
>> +        if (vq->vring.desc[i].len<  vq->indirect_alloc_thresh)
> This should be > instead of <,  no?

It should, yeah.

Too bad slub doesn't yell at you for doing that.

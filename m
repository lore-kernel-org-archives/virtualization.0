From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] virtio: Work around frames incorrectly marked as gso
Date: Mon, 09 Dec 2019 11:54:46 +0100
Message-ID: <db33800253f071a1cfbb91f413af59e73faa6775.camel__24131.1826788419$1575891600$gmane$org@sipsolutions.net>
References: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: anton.ivanov@cambridgegreys.com, netdev@vger.kernel.org
Cc: mst@redhat.com, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


>  		else if (sinfo->gso_type & SKB_GSO_TCPV6)
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> -		else
> -			return -EINVAL;
> +		else {
> +			if (skb->data_len == 0)
> +				hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;


maybe use "else if" like in the before? yes, it's a different type of
condition, but braces look a bit unnatural here to me at least

johannes

From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Date: Sat, 07 Dec 2019 12:00:07 -0800 (PST)
Message-ID: <20191207.120007.1885129473331538826.davem__7011.37301964394$1575748825$gmane$org@davemloft.net>
References: <20191206143912.153583-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191206143912.153583-1-sgarzare@redhat.com>
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
Date: Fri,  6 Dec 2019 15:39:12 +0100

> When we receive a new packet from the guest, we check if the
> src_cid is correct, but we forgot to check the dst_cid.
> 
> The host should accept only packets where dst_cid is
> equal to the host CID.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied.

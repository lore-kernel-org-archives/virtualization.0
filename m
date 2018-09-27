From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH net] vhost-vsock: fix use after free
Date: Thu, 27 Sep 2018 12:52:50 +0300
Message-ID: <a413a8b4-302d-7fbc-092d-95e8aa421c4c__43588.4812068709$1538041852$gmane$org@cogentembedded.com>
References: <20180927084301.573-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180927084301.573-1-jasowang@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, stefanha@redhat.com, mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello!

On 9/27/2018 11:43 AM, Jason Wang wrote:

    Just a couple of typos...

> The access of vsock is not protected by vhost_vsock_lock. This may
> lead use after free since vhost_vsock_dev_release() may free the

   Lead to use.

> pointer at the same time.
> 
> Fix this by holding the lock during the acess.

    Access.

> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
[...]

MBR, Sergei

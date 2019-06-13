From: Hillf Danton <hdanton@sina.com>
Subject: Re: memory leak in vhost_net_ioctl
Date: Thu, 13 Jun 2019 20:06:59 +0800
Message-ID: <20190613120659.10680-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "mst@redhat.com" <mst@redhat.com>, syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


Hello Jason

On Thu, 13 Jun 2019 17:10:39 +0800 Jason Wang wrote:
> 
> This is basically a kfree(ubuf) after the second vhost_net_flush() in
> vhost_net_release().
> 
Fairly good catch.

> Could you please post a formal patch?
> 
I'd like very much to do that; but I wont, I am afraid, until I collect a
Tested-by because of reproducer without a cutting edge.

Thanks
Hillf

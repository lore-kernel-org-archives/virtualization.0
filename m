From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: INFO: task hung in vhost_net_stop_vq
Date: Mon, 25 Mar 2019 10:02:43 -0400
Message-ID: <20190325100223-mutt-send-email-mst@kernel.org>
References: <0000000000004f8499057be95e1d@google.com>
	<0000000000008ee87005847fc985@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0000000000008ee87005847fc985@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>
Cc: weiyj.lk@gmail.com, kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Looks like more iotlb locking mess?

On Tue, Mar 19, 2019 at 10:21:00PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 6b1e6cc7855b09a0a9bfa1d9f30172ba366f161c
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Thu Jun 23 06:04:32 2016 +0000
> 
>     vhost: new device IOTLB API
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1486ad27200000
> start commit:   6b1e6cc7 vhost: new device IOTLB API
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1686ad27200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1286ad27200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d21e6e297322a900c128
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141db34d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ef293400000
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")

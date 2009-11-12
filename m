From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv9 3/3] vhost_net: a kernel-level virtio server
Date: Thu, 12 Nov 2009 12:48:37 +1030
Message-ID: <200911121248.38365.rusty__15997.6156814539$1257992596$gmane$org@rustcorp.com.au>
References: <cover.1257786516.git.mst@redhat.com>
	<200911101349.09783.rusty@rustcorp.com.au>
	<20091110113637.GB6989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091110113637.GB6989@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 10:06:37 pm Michael S. Tsirkin wrote:
> If tun is a module, vhost must be a module, too.
> If tun is built-in or disabled, vhost can be built-in.

I really like the brainbending :)  Keeps readers on their toes...

Applied,
Rusty.

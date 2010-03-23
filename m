From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 7/7] virtio: console: Return -EPIPE if port on the host
	isn't connected
Date: Tue, 23 Mar 2010 16:51:22 +0530
Message-ID: <20100323112122.GC3080@amit-x200.redhat.com>
References: <1269334680-1369-6-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-7-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-8-git-send-email-amit.shah@redhat.com>
	<20100323090023.GD22774@redhat.com>
	<20100323091352.GI8675@amit-x200.redhat.com>
	<4BA89C1E.7090403@redhat.com>
	<20100323105220.GK8675@amit-x200.redhat.com>
	<4BA8A03C.8030002@redhat.com>
	<20100323110957.GB3080@amit-x200.redhat.com>
	<4BA8A2C7.4070908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BA8A2C7.4070908@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Mar 23 2010 [12:15:19], Gerd Hoffmann wrote:
> On 03/23/10 12:09, Amit Shah wrote:
>> I didn't really look at blocking / non-blocking support in write()
>> because of the cpu_relax(), which will always block the app.
>
> Right, the spinning again ...
>
> When we kill this we really must care to implement blocking +  
> non-blocking + poll + partial writes correctly.

Yes; I'm adding blocking/non-blocking right away for the host_connected
condition.

Partial writes, blocking/non-blocking vq operations will have to come
for 2.6.35 at the latest.

		Amit

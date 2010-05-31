From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio: console: Fix crash when port is unplugged and
	blocked for write
Date: Mon, 31 May 2010 17:25:35 +0930
Message-ID: <201005311725.36271.rusty@rustcorp.com.au>
References: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
	<db3f30b6211d5a0b4d4e0acaddc6cedf9018e749.1274946878.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <db3f30b6211d5a0b4d4e0acaddc6cedf9018e749.1274946878.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 May 2010 05:24:40 pm Amit Shah wrote:
> When a program that has a virtio port opened and blocked for a write
> operation, a port hot-unplug event will later led to a crash when
> SIGTERM was sent to the program. Fix that.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Thanks, both applied.

Cheers,
Rusty.

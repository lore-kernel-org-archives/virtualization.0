From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: console: Enable call to hvc_remove() on console
	port remove
Date: Wed, 16 Mar 2011 14:34:44 +1030
Message-ID: <874o73iucj.fsf@rustcorp.com.au>
References: <9c2f9e719157c3330a60963a1da96f68589aa0f4.1300104945.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9c2f9e719157c3330a60963a1da96f68589aa0f4.1300104945.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 14 Mar 2011 17:45:48 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> This call was disabled as hot-unplugging one virtconsole port led to
> another virtconsole port freezing.
> 
> Upon testing it again, this now works, so enable it.

Applied,
Rusty.

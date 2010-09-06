From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 02/14] virtio: console: Remove control vq data only if
	using multiport support
Date: Mon, 6 Sep 2010 17:59:39 +0930
Message-ID: <201009061759.40423.rusty@rustcorp.com.au>
References: <cover.1283430900.git.amit.shah@redhat.com>
	<c7259c88e3dc036806629cd31f08e8b54fa1c345.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c7259c88e3dc036806629cd31f08e8b54fa1c345.1283430900.git.amit.shah@redhat.com>
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

On Thu, 2 Sep 2010 10:11:41 pm Amit Shah wrote:
> If a portdev isn't using multiport support, it won't have any control vq
> data to remove.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

So previously it would crash if it was ever removed?  If so, it'd be
nice to see that in the patch description :)

Thanks,
Rusty.

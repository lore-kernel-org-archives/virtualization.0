From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/1] virtio: console: remove unnecessary null test before
	debugfs_remove_recursive
Date: Mon, 30 Jun 2014 12:16:03 +0530
Message-ID: <20140630064603.GA27557@grmbl.mre>
References: <1404031293-5678-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1404031293-5678-1-git-send-email-fabf@skynet.be>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) 29 Jun 2014 [10:41:33], Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
> 
> Cc: Amit Shah <amit.shah@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

Rusty, can you pick this up please?

Thanks,

		Amit

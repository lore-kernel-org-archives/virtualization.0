From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/1] virtio: console: remove unnecessary null test before
	debugfs_remove_recursive
Date: Wed, 09 Jul 2014 09:53:50 +0930
Message-ID: <871ttv752h.fsf@rustcorp.com.au>
References: <1404031293-5678-1-git-send-email-fabf@skynet.be>
	<20140630064603.GA27557@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140630064603.GA27557@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Sun) 29 Jun 2014 [10:41:33], Fabian Frederick wrote:
>> Fix checkpatch warning:
>> WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
>> 
>> Cc: Amit Shah <amit.shah@redhat.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: virtualization@lists.linux-foundation.org
>> Signed-off-by: Fabian Frederick <fabf@skynet.be>
>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>
>
> Rusty, can you pick this up please?

Applied.

Thanks,
Rusty.

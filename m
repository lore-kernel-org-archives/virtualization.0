From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch v2] virtio_console: silence a static checker warning
Date: Fri, 8 May 2015 15:18:45 +0300
Message-ID: <20150508121844.GE16501@mwanda>
References: <20150508091624.GS14154@mwanda> <554C8221.9070304@bfs.de>
	<20150508095616.GB5527@grmbl.mre> <554C9A52.4030707@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <554C9A52.4030707@bfs.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: walter harms <wharms@bfs.de>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 08, 2015 at 01:13:22PM +0200, walter harms wrote:
> The basic idea was to limit the space, having leading zeros is my idea because
> i found this more convenient in the past. Using something like "%3u" will give
> static checkers a chance to detect the required max. space.

How are you calculating the %3?

The max for "id" is currently 31.  To be honest, I'm not certain the max
for ->index.  It's something in qemu but I'm not sure what.  Who is
going to keep it updated?

The %3 is sort of meaningless.  The lower levels of the code just ignore
it don't they?

regards,
dan carpenter

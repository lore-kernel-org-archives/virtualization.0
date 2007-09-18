From: Charles N Wyble <charles@thewybles.com>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 13:04:32 -0700
Message-ID: <46F02F50.5000001__4356.74712430245$1190146095$gmane$org@thewybles.com>
References: <1189747054.7262.34.camel@localhost.localdomain>	<1189747124.7262.36.camel@localhost.localdomain>	<1189747280.7262.39.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709181257.41530.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andi Kleen wrote:
> On Friday 14 September 2007 07:21, Rusty Russell wrote:
>> It's pretty widely used,
> 
> Is it? By whom?
> 
>> and the distributions will turn it on. 
> 
> That's no reason to make it default y. Please undo that. default y
> is near always a bad idea.


Andi,

	What do you base this on? Why is making something default y a bad idea?
Those most likely to care can turn it off. Is there a harmful effect
from leaving it on if its not being used?



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG8C9QkQPZV56XDBMRAowcAJ9fkxKAjjsvGd6hOPkvHXU9ThpoQwCdGUI8
mjpUh6G+ZyzL0CW3sYNS97g=
=ZgiJ
-----END PGP SIGNATURE-----

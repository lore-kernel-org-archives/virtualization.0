From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: netlink versus pid namespaces
Date: Fri, 15 Oct 2010 19:19:03 +0400
Message-ID: <20101015151903.GA3487__3028.08786877922$1287416310$gmane$org@ms2.inr.ac.ru>
References: <20101015142357.GA29321@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101015142357.GA29321@basil.fritz.box>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

Hello!

> netlink uses pids (or really tids I hope?) to address sockets
> associated with processes.

Not really. It uses port number which is called "pid" occasionally. Bad name.
Autobind function simply selects tgid of calling process as the first guess.

Actually sockets are addressed by pair (net namespace, port) and
communication is possible only inside net namespace. So, communication
between namespaces is already prohibited.

pid namespaces do not participate in the picture at all.

Alexey

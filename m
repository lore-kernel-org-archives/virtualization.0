From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: Tree for Feb 13 (virtio_console)
Date: Thu, 14 Feb 2013 16:02:29 -0800
Message-ID: <20130215000229.GA5164__46837.3782038272$1360886579$gmane$org@kroah.com>
References: <20130213193532.162080d7c0557a307ab451ac@canb.auug.org.au>
	<511BEC55.5090801@infradead.org> <87sj4zk3ai.fsf@rustcorp.com.au>
	<511D30B4.5020201@infradead.org> <511D330A.2050407@infradead.org>
	<20130215105519.1d8de65d4f9195eeb9306c13@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130215105519.1d8de65d4f9195eeb9306c13@canb.auug.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Joe Millenbach <jmillenbach@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 15, 2013 at 10:55:19AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> The patch below is needed in the tty tree (which introduced CONFIG_TTY).

Ok, now done.

> Also, has someone checked to see if any of the CONFIG_ symbols that had a
> dependency on TTY added are selected anywhere else?

Joe did all of that I think.  Joe?

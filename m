From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Wed, 2 Jan 2019 13:00:24 -0800
Message-ID: <20190102210024.GJ6310__30437.0189471685$1546462717$gmane$org@bombadil.infradead.org>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-4-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-4-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Lustig <dlustig@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Luc Maranget <luc.maranget@inria.fr>, Richard Henderson <rth@twiddle.net>, Jade Alglave <j.alglave@ucl.ac.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.orgLuc Van Oostenryck <luc.>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 02, 2019 at 03:57:58PM -0500, Michael S. Tsirkin wrote:
> @@ -875,6 +893,8 @@ to the CPU containing it.  See the section on "Multicopy atomicity"
>  for more information.
>  
>  
> +
> +
>  In summary:
>  
>    (*) Control dependencies can order prior loads against later stores.

Was this hunk intentional?

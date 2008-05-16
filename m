From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Fri, 16 May 2008 13:25:09 -0700
Message-ID: <482DEDA5.9080309__26186.6324035966$1210969880$gmane$org@zytor.com>
References: <482C8595.5030509@garzik.org>	
	<200805160943.08788.rusty@rustcorp.com.au>	
	<200805161531.44725.rusty@rustcorp.com.au>	
	<200805161539.59739.rusty@rustcorp.com.au>
	<1210934981.6381.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1210934981.6381.1.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Johannes Berg wrote:
>> +
>> +/* Our random number generator device reads from /dev/urandom into the Guest's
>> + * input buffers.  The usual case is that the Guest doesn't want random numbers
>> + * and so has no buffers although /dev/urandom is still readable, whereas
>> + * console is the reverse.
> 
> Is it really a good idea to use the hosts /dev/urandom to fill the
> guests /dev/random?

Only if you have an entropy estimate to go with it.  It's still dubious, 
though: the guests own pool will do its own mixing, so you might as well 
pull from /dev/random in the host as being a genuine entropy source and 
only add what entropy is available.

	-hpa

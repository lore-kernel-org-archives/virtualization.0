From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 11/11] vsock_test: wait for the remote to close the
	connection
Date: Thu, 22 Aug 2019 11:15:46 +0200
Message-ID: <20190822091546.qcns2kot6tzju7yv__41272.9713645362$1566465362$gmane$org@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-12-sgarzare@redhat.com>
	<20190820082828.GA9855@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190820082828.GA9855@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 20, 2019 at 09:28:28AM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:25:41PM +0200, Stefano Garzarella wrote:
> > +/* Wait for the remote to close the connection */
> > +void vsock_wait_remote_close(int fd)
> > +{
> > +	struct epoll_event ev;
> > +	int epollfd, nfds;
> > +
> > +	epollfd = epoll_create1(0);
> > +	if (epollfd == -1) {
> > +		perror("epoll_create1");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	ev.events = EPOLLRDHUP | EPOLLHUP;
> > +	ev.data.fd = fd;
> > +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) == -1) {
> > +		perror("epoll_ctl");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	nfds = epoll_wait(epollfd, &ev, 1, TIMEOUT * 1000);
> > +	if (nfds == -1) {
> > +		perror("epoll_wait");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	if (nfds == 0) {
> > +		fprintf(stderr, "epoll_wait timed out\n");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	assert(nfds == 1);
> > +	assert(ev.events & (EPOLLRDHUP | EPOLLHUP));
> > +	assert(ev.data.fd == fd);
> > +
> > +	close(epollfd);
> > +}
> 
> Please use timeout_begin()/timeout_end() so that the test cannot hang.
> 

I used the TIMEOUT macro in the epoll_wait() to avoid the hang.
Do you think is better to use the timeout_begin()/timeout_end()?
In this case, should I remove the timeout in the epoll_wait()?

> > diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> > index 64adf45501ca..a664675bec5a 100644
> > --- a/tools/testing/vsock/vsock_test.c
> > +++ b/tools/testing/vsock/vsock_test.c
> > @@ -84,6 +84,11 @@ static void test_stream_client_close_server(const struct test_opts *opts)
> >  
> >  	control_expectln("CLOSED");
> >  
> > +	/* Wait for the remote to close the connection, before check
> > +	 * -EPIPE error on send.
> > +	 */
> > +	vsock_wait_remote_close(fd);
> 
> Is control_expectln("CLOSED") still necessary now that we're waiting for
> the poll event?  The control message was an attempt to wait until the
> other side closed the socket.

Right, I'll remove it in the v3

Thanks,
Stefano

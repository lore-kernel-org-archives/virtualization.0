From: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: Strange finding about kernel samepage merging
Date: Mon, 6 Feb 2012 21:35:44 -0600
Message-ID: <CANAOKxs8j2T2b0tKssFX9NeC1wyMqjLMQmgmRwMs9qvokYcW2w__38686.7046858699$1328585754$gmane$org@mail.gmail.com>
References: <CAG4AFWaXVEHP+YikRSyt8ky9XsiBnwQ3O94Bgc7-b7nYL_2PZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7008681744763332754=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG4AFWaXVEHP+YikRSyt8ky9XsiBnwQ3O94Bgc7-b7nYL_2PZQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jidong Xiao <jidong.xiao@gmail.com>
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============7008681744763332754==
Content-Type: multipart/alternative; boundary=f46d043bd6fe5d249c04b857797a

--f46d043bd6fe5d249c04b857797a
Content-Type: text/plain; charset=ISO-8859-1

My guess is you end up with 2 copies of each page on the guest: the copy in
the guest's page cache, and the copy in the buffer you allocated. From the
perspective of the host this all looks like anonymous memory, so ksm merges
the pages.

--f46d043bd6fe5d249c04b857797a
Content-Type: text/html; charset=ISO-8859-1

My guess is you end up with 2 copies of each page on the guest: the copy
 in the guest&#39;s page cache, and the copy in the buffer you allocated. From the 
perspective of the host this all looks like anonymous memory, so ksm 
merges the pages.<br>

--f46d043bd6fe5d249c04b857797a--

--===============7008681744763332754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7008681744763332754==--
